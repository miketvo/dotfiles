from sys import exit
from pathlib import Path
from i3ipc import Connection
import subprocess


def get_current_workspace(i3):
    tree = i3.get_tree()
    return tree.find_focused().workspace()


def on_event(i3):
    home_dir = str(Path.home())
    current_workspace = get_current_workspace(i3)
    container_count = len(current_workspace.leaves()) if current_workspace else 0
    if container_count == 0:
        subprocess.run(["feh", "--no-fehbg", "--bg-fill", f"{home_dir}/.fehbg-light.jpg"])
        pass
    else:
        subprocess.run(["feh", "--no-fehbg", "--bg-fill", f"{home_dir}/.fehbg-dark.jpg"])
        pass


def main():
    i3 = Connection()
    i3.on("workspace::focus", lambda i3con, _: on_event(i3con))
    i3.on("window::new", lambda i3con, _: on_event(i3con))
    i3.on("window::close", lambda i3con, _: on_event(i3con))
    i3.on("window::move", lambda i3con, _: on_event(i3con))
    i3.main()


if __name__ == "__main__":
    main()
    exit(0)
