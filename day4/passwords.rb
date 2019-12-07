class Passwords
  def guesser(range)
    guesses = []
    range.each do |g|
      guesses.append(g) if legal?(g)
    end
    # puts range.count
    # puts guesses.count
    guesses
  end

  def legal?(password)
    nondescending?(password) && double?(password)
  end

  def nondescending?(password)
    true if descend_check(password)
  end

  def descend_check(password)
    arrPass = password.to_s.split("")
    arrPass == arrPass.sort
  end

  def double?(password)
    true if double_check(password)
  end

  def double_check(password)
    arrPass = password.to_s.split("")

    return false if arrPass.uniq.count == 1
    return false if arrPass.uniq.count == 6

    return true if arrPass[0] == arrPass[1] && arrPass[0] != arrPass[2]
    return true if arrPass[4] == arrPass[5] && arrPass[4] != arrPass[3]

    if arrPass[1] == arrPass[2] && arrPass[1] != arrPass[3]
      return true if arrPass[1] != arrPass[0]
    end

    if arrPass[2] == arrPass[3] && arrPass[2] != arrPass[4]
      return true if arrPass[2] != arrPass[1]
    end

    if arrPass[3] == arrPass[4] && arrPass[3] != arrPass[5]
      return true if arrPass[3] != arrPass[2]
    end
  end
end

# range = (128392..643281)
# puts Passwords.new.guesser(range).count
