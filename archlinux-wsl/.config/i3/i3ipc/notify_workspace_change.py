from sys import exit
from i3ipc import Connection
import subprocess


def get_current_workspace(i3):
    tree = i3.get_tree()
    return tree.find_focused().workspace()


def on_event(i3):
    current_workspace = get_current_workspace(i3)
    subprocess.run(["twmnc", "-t", f" Workspace {current_workspace.name} ", "-d", "1000", "--id", "80"])


def main():
    i3 = Connection()
    i3.on("workspace::focus", lambda i3con, _: on_event(i3con))
    i3.main()


if __name__ == "__main__":
    main()
    exit(0)
