require "openai"
require "json"

class OcrReminder
  def initialize(photo)
    @encoded_photo = encode_image(photo)
    @client = OpenAI::Client.new
  end

  def call
    set_reminder
  end

  private

  def set_reminder
  prompt = "Je t'écris en français, tu me réponds en français.
Je t'envoie la photo d'un rappel, contenant des rendez-vous ou des tâches à accomplir.
La photo est celle d'un document papier écrit à la main.

Voici un model de rappel :
-description: text,
-end_date: datetime

Tu dois :
1. Un rappel contient une datetime et une description. Extraire chaque rappel séparément, de façon claire et lisible.
2. Identifier la date associée au rappel si elle est mentionnée (par exemple, '12 décembre').
   - Si l'année n'est pas explicitement écrite, considère que la date appartient à l'année en cours (2024).
   - La date est ultérieure à la date du jour
3. Si un rappel est ambigu ou difficile à lire, utilise une approximation basée sur la correspondance française la plus proche.

Ta réponse doit être :
- Strictement un JSON valide sans texte supplémentaire ni balises de code.
- Au format suivant pour chaque rappel :
{
  'description': 'rappel',
  'end_date': 'YYYY-dd-MM'T'HH:mm',
}
### Règles importantes :
- Les clés **description** et **end_date** doivent être entourées de guillemets doubles : `'description'` `'end_date`'.
- Aucune information superflue (comme `\n`, `\`, ou autres caractères inutiles).
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
