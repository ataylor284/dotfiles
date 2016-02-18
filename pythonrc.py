import atexit
import os
import rlcompleter
import readline

# enable readline tab completion
readline.parse_and_bind('tab: complete')

# reload history from past sessions
history = os.path.expanduser("~/.python_history")

if os.path.exists(history):
    try:
        readline.read_history_file(history)
    except IOError, e:
        print("%s: %s" % (history, e.strerror))

readline.set_history_length(5000)

# write history before exit
def write_history(history):
    def wrapped():
        import readline
        try:
            readline.write_history_file(history)
        except IOError, e:
            print("%s: %s" % (history, e.strerror))
    return wrapped

atexit.register(write_history(history))
