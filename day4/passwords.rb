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
    checks = []

    if arrPass[0] == arrPass[1] && arrPass[0] != arrPass[2]
      checks.append(true)
    elsif arrPass[0] == arrPass[1] && arrPass[0] == arrPass[2]
      checks.append(false)
    end
    
    if arrPass[1] == arrPass[2] && arrPass[1] != arrPass[3]
      if arrPass[1] == arrPass[0]
        checks.append(false)
      else
        checks.append(true)
      end
    elsif arrPass[1] == arrPass[2] && arrPass[1] == arrPass[3]
      checks.append(false)
    end

    if arrPass[2] == arrPass[3] && arrPass[2] != arrPass[4]
      if arrPass[2] != arrPass[1]
        checks.append(true)
      else
        checks.append(false)
      end
    elsif arrPass[2] == arrPass[3] && arrPass[2] == arrPass[4]
      checks.append(false)
    end

    if arrPass[3] == arrPass[4] && arrPass[3] != arrPass[5]
      if arrPass[3] != arrPass[2]
        checks.append(true)
      else
        checks.append(false)
      end
    elsif arrPass[3] == arrPass[4] && arrPass[3] == arrPass[5]
      checks.append(false)
    end

    if arrPass[4] == arrPass[5] && arrPass[4] != arrPass[3]
      checks.append(true)
    else
      checks.append(false)
    end
    
    checks.any?
  end
end
