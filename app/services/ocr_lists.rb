require "openai"
require "json"

class OcrLists

def initialize
  @client = OpenAI::Client.new
end

def vision
@photo = encode_image
client = OpenAI::Client.new
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
      "url": "data:image/jpeg;base64,#{@photo}",
    },
  }
]

response = client.chat(
  parameters: {
    model: "gpt-4o-mini",
    #response_format: "json",
    messages: [{ role: "user", content: messages }],
  }
)

#file = URI.parse(url).open
raise
response

    return response.choices[0]
end

def encode_image
  file_content = File.read(params[:ocr][:temp_photo].tempfile)
  Base64.strict_encode64(file_content)
end
