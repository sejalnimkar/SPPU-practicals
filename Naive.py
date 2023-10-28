import time
st = time.time()


def search(pat, txt):
    pat_len = len(pat)
    text_len = len(txt)
    for i in range(text_len - pat_len + 1):
        if txt[i:i+pat_len] == pat:
            print(f"Pattern found at index {i}")


txt = "AABAACAADAABAAABAA"
pat = "AABA"
search(pat, txt)
et = time.time()
print("Execution time:", et-st, "seconds")
