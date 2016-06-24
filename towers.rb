class TOH
  @@point_a = Array.new()
  @@point_b = Array.new()
  @@point_c = Array.new()
  @@locations = [@@point_a, @@point_b, @@point_c]

  #words
  def initialize(towers)
    @towers = towers
    #creates towers
    @towers.times do |num|
      @@point_a.push(num+1)
    end 
    puts "\nWelcome to Tower of Hanoi!"
    puts " Instructions:"
    puts " Enter where you'd like to move from and to"
    puts " in the format [1,3]. Enter 'q' to quit. \n \n"
  end

  #main
  def play()
    #visual
    render()
    while game_over() == false
      input = user_input()
      #checks and does user input
      if check_level(input) == true
        do_user_input(input)
      end
      render()
    end
  end
    
  #returns a 2 char string, string[0], string[1] as from, to
  def user_input()
    instructions = gets
    two_string_num = instructions.gsub(/\D/, '')
    return two_string_num
  end
    
  def check_level(from_to)
    #if empty
    if @@locations[from_to[1].to_i-1].length == 0
      return true
    #tower that is placed in the 'to' location must be lesser value than towers initially there
    else 
      @@locations[from_to[1].to_i-1].each do |tower|
        if tower < @@locations[from_to[0].to_i-1][0]
          return false
        else 
          return true
        end
      end
    end
  end

  def do_user_input(from_to)
    tower_value = @@locations[from_to[0].to_i-1][0]
    @@locations[from_to[0].to_i-1].delete_at(0)
    @@locations[from_to[1].to_i-1].insert(0,tower_value)
  end

  def game_over()
    if @@point_c[0] == 1 && @@point_c[1] == 2 && @@point_c[2] == 3 #.length == @towers
      return true
    else 
      return false
    end
  end

  def render()
    filler = ["a","b","c"]

    #creates levels of strings depending on initialize
    lines = []
    @towers.times do
      temp = ""
      @towers.times do |num|
        letter = filler[num]
        temp += "#{letter}    "
      end 
      lines.insert(0, temp)
    end

    #I did this because without the 0s towers wouldn't be pushed down to floor level. 0s act as placeholder for empty.
    #temp fills blank spots with 0s 
    @@locations.each do |arr|
      while arr.length < 3
        arr.insert(0, 0)
      end
    end

    #adds visual towers by manipulating lines
    @@locations.each do |arr|
      arr.reverse_each do |tower|
        if tower != nil
          visual = ""
          tower.times do
            visual += "o"
          end
        loc = @@locations.index(arr)
        index = arr.index(tower)
        lines[index] = lines[index].sub(filler[loc], visual)
        puts lines[index]
        puts " "
        end
      end
    end

    #removes filler 0s
    @@locations.each do |arr|
      arr.delete(0)
    end

    puts lines
    1.upto(3) {|num| print "#{num}    "}
    print "\n\nlines: ", lines
    print "\n1: ", @@locations[0], "\n"
    print "2: ", @@locations[1], "\n"
    print "3: ", @@locations[2], "\n"
  end
end

t = TOH.new(3)
t.play