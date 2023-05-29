require 'httparty'
require 'json'

#Funcion para enviar promt a chat gpt
def enviar_prompt(prompt)
  url = 'https://api.openai.com/v1/chat/completions'
  headers = {
    'Content-Type' => 'application/json',
    'Authorization' => 'Bearer My_Apikey'
  }

  body = {
    'prompt' => prompt,
    'max_tokens' => 500
  }

  response = HTTParty.post(url, headers: headers, body: body.to_json)
  data = JSON.parse(response.body)

  if response.code.to_i == 200
    return data['choices'][0]['text'].strip
  else
    puts "Error en la solicitud: #{response.code} #{response.message}"
    return nil
  end
end

#Funcion para generar archivo fisico
def generar_archivo (texto, nombre_archivo)
    
    nombre_archivo = nombre_archivo
    
    archivo = File.new("#{nombre_archivo}.txt", "w")
    archivo.puts(texto)
    archivo.close
    
    puts "Archivo generado exitosamente: #{nombre_archivo}.txt"
end


#Programa principal
nombre_archivo = "archivo"
puts "Ingresa tu prompt:"
prompt = gets.chomp

respuesta = enviar_prompt(prompt)

if respuesta.nil?
  mensaje = "No se pudo obtener una respuesta del modelo."
else
  mensaje = "Respuesta del modelo:\n" + respuesta
end

puts mensaje

generar_archivo(respuesta, nombre_archivo)
