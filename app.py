from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

API_KEY = "your_openweather_api_key"
BASE_URL = "https://api.openweathermap.org/data/2.5/weather"

@app.route('/weather', methods=['GET'])
def get_weather():
    city = request.args.get('city')
    if not city:
        return jsonify({"error": "City not provided"}), 400

    response = requests.get(BASE_URL, params={"q": city, "appid": API_KEY, "units": "metric"})
    if response.status_code != 200:
        return jsonify({"error": "Failed to fetch weather data"}), response.status_code

    data = response.json()
    weather_info = {
        "city": data["name"],
        "temperature": data["main"]["temp"],
        "description": data["weather"][0]["description"],
    }
    return jsonify(weather_info)

if __name__ == '__main__':
    app.run(debug=True)