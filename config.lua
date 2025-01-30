Config = {}

Config.Jobs = {
    ['police'] = {
        salary = 1500,
        interval = 10, -- intervalo en minutos
        lastPayout = 0
    },
    ['ambulance'] = {
        salary = 1400,
        interval = 15,
        lastPayout = 0
    },
    ['mechanic'] = {
        salary = 1200,
        interval = 20,
        lastPayout = 0
    },
    ['unemployed'] = {
        salary = 500,
        interval = 30,
        lastPayout = 0
    }
}

Config.PaymentMessage = "Has recibido tu salario: $%s"
