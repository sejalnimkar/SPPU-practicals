# HUFFMAN CODING
import heapq


class huffman:
    def __init__(self, data):
        self.heap = []
        self.codes = {}
        self.text = data
        self.frequency = self.make_freq_dict()

    class heapnode:
        def __init__(self, char, freq):
            self.char = char
            self.freq = freq
            self.left = None
            self.right = None

        def __lt__(self, other):
            return self.freq < other.freq

        def __eq__(self, other):
            return self.freq == other.freq

        def __ne__(self, other):
            return self.freq != other.freq

    def make_freq_dict(self):
        frequency = {}
        for character in self.text:
            if not character in frequency:
                frequency[character] = 0
            frequency[character] += 1
        return frequency

    def make_priority_queue(self):
        for key in self.frequency.keys():
            node = self.heapnode(key, self.frequency[key])
            heapq.heappush(self.heap, node)

    def make_huffman_tree(self):
        while(len(self.heap) > 1):
            node1 = heapq.heappop(self.heap)
            node2 = heapq.heappop(self.heap)

            merged = self.heapnode(None, node1.freq+node2.freq)
            merged.left = node1
            merged.right = node2
            heapq.heappush(self.heap, merged)

    def make_code_helper(self, node, current_code):
        if node is None:
            return
        if node.char != None:
            self.codes[node.char] = current_code
        self.make_code_helper(node.left, current_code+"0")
        self.make_code_helper(node.right, current_code+"1")

    def make_char_codes(self):
        root = heapq.heappop(self.heap)
        self.make_code_helper(root, "")

    def huffman_tree(self):
        self.make_priority_queue()
        self.make_huffman_tree()
        self.make_char_codes()
        for i in self.codes.keys():
            print(f"Character code for {i} is {self.codes[i]}")


huffman_instance = huffman("you're awesome")
huffman_instance.huffman_tree()
