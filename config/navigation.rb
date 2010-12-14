SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :tutorial, '/ Tutorial', tutorial_path, :highlights_on => /\/tutorial/
  end
end