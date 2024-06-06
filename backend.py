from flask import Flask, request, jsonify
import json

app = Flask(__name__)

@app.route('/api/receive', methods=['POST'])
def receive_env_files():
    env_files = request.data.decode('utf-8')
    env_files_list = env_files.split('\n')
    env_dict = {}

    # Parse .env files list and store content in a dictionary
    for file_path in env_files_list:
        if file_path:
            file_content = ""
            with open(file_path, "r") as file:
                file_content = file.read()
            env_dict[file_path] = file_content

    # Save the dictionary as a JSON file
    with open("env_files.json", "w") as json_file:
        json.dump(env_dict, json_file, indent=2)

    # Return a success message
    return jsonify({"message": "Received .env files list successfully and saved to env_files.json"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5045)
