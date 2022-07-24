FROM nim:latest

WORKDIR /dye

COPY . .

RUN nimble web

EXPOSE 5000

CMD ["nimble", "serve"]

