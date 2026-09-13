from .metadata import get_metadata

def main() -> None:
    print("Hello from todo-src!")

    title, description = get_metadata('https://chatgpt.com/')

    print(title)
    print(description)
