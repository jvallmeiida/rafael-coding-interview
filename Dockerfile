# Use uma imagem oficial do Ruby
FROM ruby:2.7.6

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  && rm -rf /var/lib/apt/lists/*

# Criar o diretório do projeto e definir como o diretório de trabalho
WORKDIR /myapp

# Copiar os arquivos do projeto para o diretório de trabalho
COPY . .

# Instalar as dependências do projeto
RUN bundle install

# Expor a porta para o servidor Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
