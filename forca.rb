class Forca
  
  def initialize(so = "linux")
    if so.downcase == "windows"
      cont = 0
    else
      cont = 1
    end
    @contador = cont
    @palavra = self.selecionar_palavra()
    @tamanho_palavra = @palavra.length - cont
    @enigma = []
    @tamanho_palavra.times { @enigma.push "_ " }
    @tentativas = @tamanho_palavra * 2
  end
  
  def selecionar_palavra
    v = []
    File.open('palavras.txt','r') do |arq|
      while line = arq.gets
        v.push(line)
      end
    end
    v.sample.split("")
  end
    
  def perguntar_letra
    print "Digite uma letra: "
    gets.chomp.upcase
  end
  
  def limpar_tela
    system("clear")
    puts
  end

  def verificar_se_ganhou
    if @contador == (@palavra.size)
      limpar_tela()
      print @enigma
      puts
      puts "Voce venceu!"
      exit
    else
      @tentativas += 1 
    end
  end
  
  def verificar_se_perdeu(status)
    if @tentativas < @tamanho_palavra * 2  && status == "errou"
      puts "Restam " + @tentativas.to_s + " tentativas."
      sleep(1)
    elsif @tentativas == 0
      puts "Voce perdeu!"
      print "Palavra correta: "
      @palavra.each{|x| print x.upcase}
      exit
    end
  end

  def verificar_letra
    letra = perguntar_letra()
    @palavra.each_with_index do |v,i|
      if letra == v.upcase && @enigma[i] != letra
        @contador += 1
        @enigma[i] = v.upcase
        verificar_se_ganhou()
        "acertou"
      else
        "errou"
      end
    end
    @tentativas -= 1
  end
  
  def jogar
    while @contador <= @tamanho_palavra do
      limpar_tela()
      print @enigma
      puts
      verificar_se_perdeu(verificar_letra())
    end
  end
end

j = Forca.new
j.jogar
