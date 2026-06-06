import requests

city = "Kielce"
url = f"https://wttr.in/{city}?format=j1"

data = requests.get(url).json()

current = data["current_condition"][0]
print("Temperatura:", current["temp_C"], "°C")
print("Opis:", current["weatherDesc"][0]["value"])
