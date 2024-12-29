function ls --wraps=lsd --description 'alias ls lsd'
  lsd $argv
end

function ll --wraps=lsd --description 'alias ll lsd -l'
  lsd -l $argv
end

function la --wraps=lsd --description 'alias la lsd -l'
  lsd -a $argv
end
