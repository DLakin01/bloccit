module RandomData
  lorem_ipsum = ['lorem', 'ipsum', 'dolor', 'sit', 'amet', 'consectetur',
    'adipiscing', 'elit', 'ut', 'dapibus', 'quis', 'dui', 'eget', 'facilisis',
    'praesent', 'ac', 'massa', 'fringilla', 'sodales', 'massa', 'commodo', 'efficitur',
    'ante', 'curabitur', 'at', 'est', 'sodales', 'euismod', 'ligula', 'vel', 'lacinia',
    'felis', 'morbi', 'tristique', 'id', 'urna', 'sed', 'viverra', 'suspendisse',
    'iaculis', 'magna', 'non', 'ornare', 'finibus', 'Morbi', 'et', 'magna', 'ultrices',
    'nibh', 'hendrerit']

  def self.random_paragraph
    sentences = []
    rand(4..9).times do
      sentences << random_sentence
    end

    sentences.join(" ")
  end

  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  def self.random_word
    lorem_ipsum = ['lorem', 'ipsum', 'dolor', 'sit', 'amet', 'consectetur',
      'adipiscing', 'elit', 'ut', 'dapibus', 'quis', 'dui', 'eget', 'facilisis',
      'praesent', 'ac', 'massa', 'fringilla', 'sodales', 'massa', 'commodo', 'efficitur',
      'ante', 'curabitur', 'at', 'est', 'sodales', 'euismod', 'ligula', 'vel', 'lacinia',
      'felis', 'morbi', 'tristique', 'id', 'urna', 'sed', 'viverra', 'suspendisse',
      'iaculis', 'magna', 'non', 'ornare', 'finibus', 'Morbi', 'et', 'magna', 'ultrices',
      'nibh', 'hendrerit']
    lorem_ipsum[rand(0..49)]
  end
end
