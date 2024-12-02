require "openai"
require "json"

class OcrList

  def initialize(photo)
    @encoded_photo = encode_image(photo)
    @client = OpenAI::Client.new
  end

  def call
    set_vision
  end

  private

  def set_vision

  prompt = "Je t'écris en français, tu me réponds en français.
Je t'envoie la photo d'une to-do list.
La photo est celle d'un document papier avec une écriture à la main.
Tu dois extraire chaque élément de la liste séparément.
Si tu n'es pas sûr d'un élément, trouve la correspondance française la plus proche.

Ta réponse doit être strictement un JSON valide, sans texte additionnel ni balises de code.
Le format attendu est :

{
  'tasks': ['valeur1', 'valeur2', 'valeur3']
}

Assure-toi que :
- La clé est entourée de guillemets doubles : `'tasks'`.
- Les éléments de la liste sont dans un tableau JSON, entourés de guillemets doubles.
- Aucun caractère d'échappement inutile comme `\n` ou `\`.
- Si la liste est vide, retourne un JSON valide : `{'tasks': []}`.
"

  messages = [
    { "type": "text", "text": prompt },
    { "type": "image_url",
      "image_url": {
        "url": "data:image/jpeg;base64,#{@encoded_photo}",
      },
    }
  ]

  response = @client.chat(
    parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: messages }],
    }
  )
    return JSON.parse(response["choices"][0]["message"]["content"])
  end

  def encode_image(photo)
    file_content = File.read(photo.tempfile)
    Base64.strict_encode64(file_content)
  end
end
