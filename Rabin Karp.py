import functools


def search(pat, txt, q):
    pat_len = len(pat)
    txt_len = len(txt)
    text_hash = 0
    pat_hash = 0
    h = 1

    for i in range(0, pat_len-1):
        h = (h*256) % q

    for i in range(0, pat_len):
        pat_hash = (256*pat_hash + ord(pat[i])) % q
        text_hash = (256*text_hash + ord(txt[i])) % q

    for i in range(0, txt_len-pat_len+1):
        if pat_hash == text_hash:
            if txt[i:i+pat_len] == pat:
                print("Pattern found at index " + str(i))

        if i < txt_len-pat_len:
            text_hash = (
                256*(text_hash-ord(txt[i])*h) + ord(txt[i+pat_len])) % q

            if text_hash < 0:
                text_hash = text_hash+q


txt = "AABAACAADAABAAABAA"
pat = "AABA"
q = 101
search(pat, txt, q)
