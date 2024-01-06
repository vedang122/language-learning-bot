from flask import Flask, request, jsonify
from openai import OpenAI

app = Flask(__name__)
MODEL_TO_USE = "gpt-3.5-turbo"
MAX_TOKEN = 250
client = OpenAI(
    # This is the default and can be omitted
    api_key='API_KEY',
)

# Request:
# {
#     "messages" : [
#         {"role": "assistant", "content": "Hello, how can I help you"},
#         {"role": "author", "content": "who is more stylish Pikachu or Neo"}
#     ],
#     "languageToPractise" : "Spanish",
#     "languageUserKnow" : "English",
#     "languageLevel" : "Beginner",
#     "situation" : "In a restaurant",
# }
# Response:
# {
#     "body": {
#         "response": {
#           "assistant": {
#               "message": "Entiendo. Las enchiladas pueden ser picantes o no picantes. ¿Prefieres algo menos picante?",
#               "translation": "I understand. Enchiladas can be spicy or not spicy. Would you prefer something less spicy?"
#           },
#           "possible_reply": {
#               "message": "Sí, prefiero algo menos picante. ¿Qué me sugieres?",
#               "translation": "Yes, I would prefer something less spicy. What do you suggest?"
#           }
#       },
#     },
#     "statusCode": 200
# }
@app.post("/")
def get_response_from_openAI():
    print("Request is:", request)
    print("Request is json:", request.is_json)
    print("Request data as text:", request.get_data(as_text=True))
    print("Request get json:", request.get_json())
    if request.is_json:
        payload = request.get_json()
        language_to_practise = payload["languageToPractise"].lower()
        language_user_know = payload["languageUserKnow"].lower()
        language_level = payload["languageLevel"].lower()
        situation = payload["situation"].lower()
        messages = payload["messages"]
        compiledMessagesPrompt = ""
        if len(messages) == 0:
            compiledMessagesPrompt += "author: "
        else:
            for message in messages:
                role = message["role"]
                content = message["content"]
                compiledMessagesPrompt += role + ": " + content + "\n"
        
        prompt = """
                    I'm learning {language_to_practise} at a {language_level} level. I want to learn it through a conversation. 
                    I want you to assume yourself a {language_to_practise} assistant who is with me {situation} and conversing with me at {language_level} level in {language_to_practise}. Can you continue the following conversation?
                    {compiledMessagesPrompt}
                    If author message is empty start conversation with a basic greeting in the language itself otherwise continue the conversation. I want you to respond in following json format:
                    {{
                        assistant: {{
		                    message: <your message in {language_to_practise}>,
    		                translation: <translation of message in {language_user_know}>
	                    }},
	                    possible_reply: {{
		                    message: <next possible reply from author to your message in {language_to_practise}>,
	                        translation: <translation of the possible reply in {language_user_know}>
                        }},
                    }}
                """.format(
                    language_to_practise = language_to_practise, 
                    language_level = language_level,
                    compiledMessagesPrompt = compiledMessagesPrompt,
                    language_user_know = language_user_know,
                    situation = situation
                )
        print("Prompt is: \n", prompt)
        response = client.chat.completions.create(
            messages=[{"role": "user", "content": prompt}],
            model="gpt-3.5-turbo",
            max_tokens=MAX_TOKEN,
            n=1,
        )
        # print(response)
        text_response = response.choices[0].message.content
        total_tokens = response.usage.total_tokens
        print(text_response)
        return {
                'response' : text_response,
                'tokens': total_tokens
            }
    return {"error": "Request must be JSON"}, 415