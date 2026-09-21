from sys import exit
from i3ipc import Connection


def get_current_workspace(i3):
    tree = i3.get_tree()
    return tree.find_focused().workspace()


def main():
    i3 = Connection()
    current_workspace = get_current_workspace(i3)
    if current_workspace:
        for leaf in current_workspace.leaves():
            i3.command(f"[con_id={leaf.id}] kill")
    else:
        return


if __name__ == "__main__":
    main()
    exit(0)
