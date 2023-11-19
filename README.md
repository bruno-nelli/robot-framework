# robot-framework
Projeto de automação de testes com Robot Framework + Aplicação local em React 

Levantando a aplicação organo para realizar os testes:

Pré requisitos: 
Ter o Python instalado
Ter o Node.js instalado
Instalar o ChromeDriver de acordo com a versão do Chrome instalado na máquina

Instalar o Robot Framework
pip install robotframework

Abrir a pasta organo no terminal;
npm install
npm start

A aplicação deve abrir em localhost:3000.





Para execução dos testes, acessar a pasta robot_framework
Executar no terminal:
Configuração de primeira execução:
pip install --upgrade robotframework-seleniumlibrary
pip install --upgrade robotframework-faker

Execução dos testes:
robot --outputdir ./results .
