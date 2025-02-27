def can_break_into_words?(s, d)
  @cache = {}
  trie = {}

  d.each do |word|
    cur_node = trie
    word.chars.each do |char|
      cur_node[char] ||= {}
      cur_node = cur_node[char]
    end
    cur_node[:end] = true
  end

  dp 0, s, trie
end

def dp(pos, s, trie)
  return true if pos == s.size

  cur_node = trie
  char_idx = 0

  @cache[pos] =
    while cur_node = cur_node[s[pos + char_idx,1]]
      if cur_node[:end]
        break true if dp pos + char_idx + 1, s, trie
      end
      char_idx += 1
    end || false if !@cache.has_key?(pos)

    @cache[pos]
end

p can_break_into_words? 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab',
  ['a', 'aa,' 'aaa', 'aaaa', 'aaaaa', 'aaaaaa', 'aaaaaaa', 'aaaaaaaa']

p can_break_into_words? 'catsandog',
  ["cats","dog","sand","and","cat"]

p can_break_into_words? 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  ['a', 'aa,' 'aaa', 'aaaa', 'aaaaa', 'aaaaaa', 'aaaaaaa', 'aaaaaaaa']
