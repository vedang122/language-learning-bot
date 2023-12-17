# app.py
from flask import Flask, request, jsonify
from openai import OpenAI

app = Flask(__name__)
MODEL_TO_USE = "gpt-3.5-turbo"
MAX_TOKEN = 100
client = OpenAI(
    # This is the default and can be omitted
    api_key='<API_KEY>',
)

# Request:
# {
#     "messages" : [
#         {"role": "system", "content": "You are a helpful assistant."},
#         {"role": "user", "content": "Hello"},
#         {"role": "assistant", "content": "Hello, how can I help you"},
#         {"role": "user", "content": "who is more stylish Pikachu or Neo"}
#     ]
# }
# Response:
# {
#     "body": {
#         "response": "Stylishness is subjective and can vary depending on personal taste. However, if we were to compare Pikachu, the iconic Pokémon character known for its adorable and electrifying appearance, with Neo, the stylish main character from the movie \"The Matrix\" portrayed by Keanu Reeves, their styles are quite different.\n\nPikachu is known for its bright yellow color, round shape, and cute features. Its style is more playful and youthful, appealing to a wide range of fans around the world.\n\n",
#         "role": "assistant",
#         "tokens": 140
#     },
#     "statusCode": 200
# }
@app.post("/response")
def get_response():
    print("Request is:", request)
    print("Request is json:", request.is_json)
    print("Request data as text:", request.get_data(as_text=True))
    print("Request get json:", request.get_json())
    if request.is_json:
        payload = request.get_json()
        print("Payload is:", payload)
        response = client.chat.completions.create(
            messages=payload['messages'],
            model="gpt-3.5-turbo",
            max_tokens=MAX_TOKEN,
            n=1,
        )
        # print(response)
        text_response = response.choices[0].message.content
        text_response_role = response.choices[0].message.role
        total_tokens = response.usage.total_tokens
        print("Test Response: ", text_response)
        return {
                'response' : text_response,
                'role': text_response_role,
                'tokens': total_tokens
            }
    return {"error": "Request must be JSON"}, 415