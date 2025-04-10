
class Queue:
    def __init__(self):
        self._contents = []
        self._size = 0
    
    def enqueue(self, data):
        self._contents.append(data)
        self._size += 1
    
    def dequeue(self):
        if (not self.isEmpty()):
            self._size -= 1
            return self._contents.pop(0)
    
    def getSize(self):
        return self._size

    def isEmpty(self):
        return (self._size == 0)

    def contents(self):
        return self._contents