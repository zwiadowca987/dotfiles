import requests
from bs4 import BeautifulSoup


def get_metadata(url):
    try:
        response = requests.get(
            url,
            headers={
                "User-Agent": "Mozilla/5.0"
            },
            timeout=10,
        )

        response.raise_for_status()

        soup = BeautifulSoup(response.text, "html.parser")

        title = soup.title.get_text(strip=True) if soup.title else None

        description_tag = soup.find(
            "meta",
            attrs={"name": "description"}
        )

        description = (
            description_tag.get("content", "").strip()
            if description_tag
            else None
        )

        return title, description

    except requests.RequestException:
        return None, None
