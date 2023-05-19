#!/bin/bash

PURPLE='0;35'
NC='\033[0m' 
VERSAO=11

pasta_origem="$HOME/Desktop/Backend-MedControll"
diretorio_destino="$HOME/Documents/"
diretorio_destino2="$HOME/Documents/Backend-MedControll/med-controll/target"

sql='
USE bd-medserver-sentinel ;

CREATE TABLE IF NOT EXISTS Maquina (
id_maquina INT NOT NULL auto_increment,
nome VARCHAR(45),
tipo VARCHAR(45),
cod_MAC VARCHAR(45) NOT NULL,
andar VARCHAR(45),
setor VARCHAR(45),
PRIMARY KEY (id_maquina))
ENGINE = InnoDB;

INSERT INTO Maquina VALUES(null,"Maquina de testes","Notebook","BFEBFBFF000806D1",1,"T.I");

CREATE TABLE IF NOT EXISTS MemoriaRam (
id_ram INT NOT NULL auto_increment,
capacidade_total VARCHAR(45) NOT NULL,
fk_maquina INT UNIQUE NOT NULL,
PRIMARY KEY (id_ram),
CONSTRAINT fk_ram_Maquina1
FOREIGN KEY (fk_maquina)
REFERENCES Maquina (id_maquina)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS DadosRam (
id_dados_ram INT NOT NULL auto_increment,
em_uso VARCHAR(45) NOT NULL,
disponivel VARCHAR(45)NOT NULL,
data_hora DATETIME NOT NULL,
fk_ram INT NOT NULL,
PRIMARY KEY (id_dados_ram),
CONSTRAINT fk_dados_ram_ram1
FOREIGN KEY (fk_ram)
REFERENCES MemoriaRam (id_ram)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Processador (
id_processador INT NOT NULL auto_increment,
nome_processador VARCHAR(200) NOT NULL,
frequencia VARCHAR(45) NOT NULL,
num_nucleo INT NOT NULL,
fk_maquina INT UNIQUE NOT NULL,
PRIMARY KEY (id_processador),
CONSTRAINT fk_cpu_Maquina1
FOREIGN KEY (fk_maquina)
REFERENCES Maquina (id_maquina)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Processo (
id_processo INT NOT NULL auto_increment,
pid INT NOT NULL,
nome VARCHAR(45) NOT NULL,
uso_cpu DOUBLE NOT NULL,
uso_ram DOUBLE NOT NULL,
fk_processador INT NOT NULL,
PRIMARY KEY (id_processo),
CONSTRAINT fk_pross_cpu1
FOREIGN KEY (fk_processador)
REFERENCES Processador (id_processador)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Janela (
id_janela INT NOT NULL auto_increment,
pid INT NOT NULL,
titulo VARCHAR(200) NOT NULL,
comando VARCHAR(200) NOT NULL,
fk_processador INT NOT NULL,
PRIMARY KEY (id_janela),
CONSTRAINT fk_janela_cpu1
FOREIGN KEY (fk_processador)
REFERENCES Processador (id_processador)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Disco (
id_disco INT NOT NULL auto_increment,
nome VARCHAR(45) NOT NULL,
tipo VARCHAR(45) NOT NULL,
total VARCHAR(45) NOT NULL,
disponivel VARCHAR(45) NOT NULL,
uuid VARCHAR(45) NOT NULL,
fk_maquina INT NOT NULL,
PRIMARY KEY (id_disco),
CONSTRAINT fk_disco_Maquina1
FOREIGN KEY (fk_maquina)
REFERENCES Maquina (id_maquina)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS DadosDisco (
id_dados_disco INT NOT NULL auto_increment,
velocida_escrita VARCHAR(45) NOT NULL,
velocidade_leitura VARCHAR(45) NOT NULL,
tempo_escrita VARCHAR(45) NOT NULL,
data_hora DATETIME NOT NULL,
fk_disco INT NOT NULL,
PRIMARY KEY (id_dados_disco),
CONSTRAINT fk_Disco_disco1
FOREIGN KEY (fk_disco)
REFERENCES Disco (id_disco)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Parametro (
id_parametro int auto_increment not null,
significativo INT NOT NULL,
moderado INT NOT NULL,
critico INT NOT NULL,
fk_maquina INT NOT NULL,
PRIMARY KEY (id_parametro),
CONSTRAINT fk_parametros_Maquina1
FOREIGN KEY (fk_maquina)
REFERENCES Maquina (id_maquina)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS SistemaOperacional (
id_sistema INT NOT NULL auto_increment,
fabricante VARCHAR(45) NOT NULL,
tipo_sistema VARCHAR(45) NOT NULL,
arquitetura VARCHAR(45) NOT NULL,
tempo_atividade VARCHAR(45) NOT NULL,
fk_maquina INT UNIQUE NOT NULL,
PRIMARY KEY (id_sistema),
CONSTRAINT fk_SISTEMA_OPERACIONAL_Maquina1
FOREIGN KEY (fk_maquina)
REFERENCES Maquina (id_maquina)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;'
	
echo  "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Olá usuário, me chamo Sentinel e serei seu assistente para instalação do Java!;"
sleep 2
echo  "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Vamos verificar se você possui o Java instalado?;"
sleep 2



java -version
if [ $? -eq 0 ]
	then
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Olá você já tem o java instalado!!"
		sleep 2
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Agora iremos verificar se você possui o docker instalado, mas antes iremos atualizar sua máquina!!"
		sleep 2
		sudo apt update -y && sudo apt upgrade -y
    sleep 2
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Atualizações de hardware efetuada com sucesso!"
		docker --version
		if [ $? -eq 0 ]
		then
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Você já possui o docker instalado!!"
		sleep 2
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Iremos configurar o container da sua aplicação, aguarde um instante!"
    sleep 2
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) :Só um momento, estou ajustando pré-definições de iniciação do docker..."
		sudo systemctl start docker
    sleep 2
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Pronto! agora o docker será iniciado junto ao sistema!"
    sleep 2
		sudo systemctl enable docker
		sleep 2
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Está quase lá, estou finalizando..."
		sleep 4
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Estou baixando a imagem do mysql!"
		sudo docker pull mysql:5.7
    sleep 2
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Pronto, baixei a imagem, agora vou criar o container com o mysql!"
		sudo docker run -d -p 3306:3306 --name ContainerMedServer -e "MYSQL_DATABASE=bd-medserver-sentinel" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Aguarde um momento, vou acessar o bash do container e criar as tabelas!"
    sleep 15
    echo "$sql" | sudo docker exec -i ContainerMedServer mysql -u root -purubu100 -h localhost bd-medserver-sentinel
    sleep 3
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Parece que finalizamos as configurações..."
		sudo docker ps -a
		sleep 2
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Container criado com sucesso! :D"
		sleep 3
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Aguarde um instante, agora vamos baixar a aplicação!"
    sleep 4
		git clone https://github.com/MedServer-Sentinel/Backend-MedControll.git
		sleep 10
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : A aplicação já foi baixada, aguarde um instante estou configurando o arquivo!"
    sleep 10
		mv "$pasta_origem" "$diretorio_destino"
    echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Criando executável na área de trabalho!"
    echo "#!/bin/bash" > med_server.sh
    echo "cd '$diretorio_destino2' " >> med_server.sh
    echo "java -jar med-controll-1.0-SNAPSHOT-jar-with-dependencies.jar" >> med_server.sh
    echo "echo 'executando java.'" >> med_server.sh
  # Permissão de execução para o novo script
    chmod +x med_server.sh

		sleep 10
		cd "$diretorio_destino"
		git checkout dev
		sleep 2
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Pronto :D ! Agora você pode executar sua aplicação, deseja iniciá-la agora? [s/n]?"
		read inst
		if [ \"$inst\" == \"s\" ]
			then
			echo "$(tput setaf 10)[Sentinel bot]:$(tput setaf 7) : Ok! Você escolheu iniciar a aplicação!"
			sleep 1
			cd "$diretorio_destino2"
			java -jar med-controll-1.0-SNAPSHOT-jar-with-dependencies.jar
		else
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Parece que você não deseja iniciar a aplicação, até logo!"

		fi
	else
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Opa! Não identifiquei nenhuma versão do Java instalado, mas sem problemas, irei resolver isso agora!"
		sleep 2
		echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Confirme para mim se realmente deseja instalar o Java (s/n)?"		
	read inst
	if [ \"$inst\" == \"s\" ]
		then
			echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Ok! Você escolheu instalar o Java ;D"
			sleep 2
			echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Adicionando o repositório!"
			sleep 2
			sudo add-apt-repository ppa:webupd8team/java -y
			clear
			echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Atualizando Pacotes! Quase lá."
			sleep 2
			sudo apt update -y
			sudo apt upgrade -y
			clear
			
			if [ $VERSAO -eq 11 ]
				then
					echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Preparando para instalar a versão 17 do Java. Confirme a instalação quando solicitado ;D"
					sleep 1
					sudo apt install default-jre ; apt install openjdk-17-jre-headless; -y
					clear
					echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Java instalado com sucesso!"
					sleep 1
          echo "$(tput setaf 10)[Sentinel Bot]:$(tput setaf 7) : Deseja baixar a aplicação (s/n)?"		
	        read inst
          if [ \"$inst\" == \"s\" ]
          then
          bash "$0"
          else 
          echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) : Você optou por não baixar a aplicação por enquanto, até a próxima então!"
          sleep 1
          exit
          exit
				fi
        else 	
        echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) : Você optou por não instalar o Java por enquanto, até a próxima então!"
        sleep 1
	  fi
  fi
  fi

# ===================================================================
# Todos direitos reservados para o autor: Dra. Profa. Marise Miranda.
# Sob licença Creative Commons @2020
# Podera modificar e reproduzir para uso pessoal.
# Proibida a comercialização e a exclusão da autoria.
# ===================================================================
