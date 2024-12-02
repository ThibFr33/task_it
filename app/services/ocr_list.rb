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

  messages = [
    { "type": "text", "text": "Je t'écris en français tu me réponds en français.

                              Je t'envoies la photo d'une to do list.
                              La photo est celle d'un document papier avec une écriture à la main.
                              Tu extraits chaque item séparemment. Si tu n'es pas sûr d'un item trouve la
                              correspondance française la plus proche."},
                              # lui demander de me faire le retour de la liste avec JSON
                              # de façon à parser sa réponse par la suite
    { "type": "image_url",
      "image_url": {
        "url": "data:image/jpeg;base64,#{@encoded_photo}",
      },
    }
  ]

  response = @client.chat(
    parameters: {
      model: "gpt-4o-mini",
      response_format: { type: "json_object" },
      messages: [{ role: "user", content: messages }],
    }
  )

  # puts response.dig("choices", 0, "message", "content")
  # =>
  # {
  #   "name": "John",
  #   "age": 30,
  #   "city": "New York",
  #   "hobbies": ["reading", "traveling", "hiking"],
  #   "isStudent": false
  # }

#file = URI.parse(url).open
    response
    return JSON.parse(response["choices"][0]["message"]["content"])
    debugger
  end

  def encode_image(photo)
    file_content = File.read(photo.tempfile)
    Base64.strict_encode64(file_content)
  end
end
