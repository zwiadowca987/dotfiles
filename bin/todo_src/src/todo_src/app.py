from textual.app import App, ComposeResult
from textual.widgets import Header, Footer, Static, Button
from textual.containers import Container, Horizontal, Vertical
from todo_src.ui import todo_display


class MyApp(App):
    def on_button_pressed(self, event: Button.Pressed) -> None:
        button_id = event.button.id
        if button_id == 'todo_list':
            self.push_screen(todo_display.TodoDisplay())
    
    def compose(self) -> ComposeResult:
        yield Header()
        yield Footer()
        with Container():
            with Horizontal():
                with Vertical():
                    yield Static('TODO')
                    yield Button('Lista', id='todo_list')
                    yield Button('Dodaj')
                    yield Button('Historia')
                with Vertical():
                    yield Static('BOOKMARKS')
                    yield Button('Lista')
                    yield Button('Dodaj')

    def on_mount(self) -> None:
        self.title = 'T&B'
        self.sub_title = 'Tasks & Bookmarks'
