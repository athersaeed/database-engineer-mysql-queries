def is_palindrome(to_check: str) -> bool:
    start = 0
    end = len(to_check) - 1
    
    while start < end:
        if to_check[start] != to_check[end]:
            return False
        
        start += 1 # incrementor for start
        end -= 1 # incrementor for end
        
    return True
