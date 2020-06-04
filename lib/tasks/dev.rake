namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") {%x(rails db:drop)}
    
      show_spinner("Criando BD...") {%x(rails db:create)}
    
      show_spinner("Migrando BD...") {%x(rails db:migrate)}
    
      %x(rails dev:add_mining_type)      

      %x(rails dev:add_coins)
     
    else 
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
         coins = [
      
                {description: "Bitcoin", 
                acronym: "BTC",
                url_image: "https://toppng.com/uploads/preview/bitcoin-png-bitcoin-logo-transparent-background-11562933997uxok6gcqjp.png", mining_type: MiningType.find_by(acronym: 'PoW')},

                {description: "Ethereum", 
                acronym: "ETH",
                url_image: "https://w7.pngwing.com/pngs/601/515/png-transparent-ethereum-cryptocurrency-blockchain-logo-neo-coin-stack-angle-triangle-logo.png", mining_type: MiningType.all.sample},
                    
                {description: "DASH", 
                acronym: "DASH",
                url_image: "https://media.dash.org/wp-content/uploads/dash-d.png", mining_type: MiningType.all.sample},

                {description: "EOS", 
                acronym: "EOS",
                url_image: "https://pngimage.net/wp-content/uploads/2018/05/eos-coin-png-4.png", mining_type: MiningType.all.sample},

                {description: "IOTA", 
                acronym: "IOTA",
                url_image: "https://guiadobitcoin.com.br/wp-content/uploads/2017/12/iota-png.png", mining_type: MiningType.all.sample}
            
    ]

    coins.each do |coin|
        Coin.find_or_create_by!(coin)  
    end 
  end
end

desc "Cadastra os tipos de mineração"
task add_mining_type: :environment do
  show_spinner("Cadastrando tipos de mineração...") do
    mining_types = [ 
            {description:"Proof of Work", acronym:"PoW"},
            {description:"Proof of Stake", acronym:"PoS"},
            {description:"Proof of Capacity", acronym:"PoC"}
    ]

    mining_types.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)  
    end
  end
end

private
  
  def show_spinner(msg_start, msg_end = "Concluído!")
     spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
     spinner.auto_spin
     yield
     spinner.success("(#{msg_end})")
  end
end
