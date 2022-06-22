class Singleton(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(Singleton, cls).__call__(*args, **kwargs)
        return cls._instances[cls]


class SingletonableClass(metaclass=Singleton):

    def __init__(self, data):
        self.data = data

    def __str__(self):
        return self.data

    def do_something(self):
        print("I did something...")


inst1 = SingletonableClass(data = 'banana')
inst2 = SingletonableClass()


if id(inst1) == id(inst2):
    print("it works, they're the same instance")
else:
    print("oh no...")

print(inst1)
print(inst2)

inst2.data = 'taco'
print(inst2)