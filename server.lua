ESX = exports["es_extended"]:getSharedObject()

-- Función para verificar si es tiempo de pago para un trabajo
local function isPaymentDue(job)
    local currentTime = os.time()
    local jobConfig = Config.Jobs[job]
    
    if jobConfig then
        local timeSinceLastPayout = currentTime - jobConfig.lastPayout
        local intervalInSeconds = jobConfig.interval * 60
        
        return timeSinceLastPayout >= intervalInSeconds
    end
    
    return false
end

-- Thread principal para el pago de salarios
Citizen.CreateThread(function()
    while true do
        -- Verificar cada minuto
        Citizen.Wait(60 * 1000)
        
        -- Obtener todos los jugadores
        local xPlayers = ESX.GetPlayers()
        
        for i=1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer then
                -- Obtener el trabajo del jugador
                local job = xPlayer.job.name
                
                -- Verificar si existe configuración para ese trabajo y si es tiempo de pago
                if Config.Jobs[job] and isPaymentDue(job) then
                    -- Actualizar tiempo del último pago
                    Config.Jobs[job].lastPayout = os.time()
                    
                    -- Pagar al jugador
                    xPlayer.addMoney(Config.Jobs[job].salary)
                    
                    -- Notificar al jugador
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 
                        string.format(Config.PaymentMessage, Config.Jobs[job].salary))
                end
            end
        end
    end
end)

-- Comando para administradores para forzar el pago
RegisterCommand('forcepay', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    -- Verificar si el jugador es admin
    if xPlayer.getGroup() == 'admin' then
        local targetJob = args[1]
        
        -- Si se especifica un trabajo, pagar solo a ese trabajo
        if targetJob and Config.Jobs[targetJob] then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                local targetPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if targetPlayer and targetPlayer.job.name == targetJob then
                    targetPlayer.addMoney(Config.Jobs[targetJob].salary)
                    TriggerClientEvent('esx:showNotification', targetPlayer.source, 
                        string.format(Config.PaymentMessage, Config.Jobs[targetJob].salary))
                end
            end
            TriggerClientEvent('esx:showNotification', source, 'Pagos forzados realizados para ' .. targetJob)
        else
            -- Pagar a todos los trabajos
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                local targetPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if targetPlayer then
                    local job = targetPlayer.job.name
                    if Config.Jobs[job] then
                        targetPlayer.addMoney(Config.Jobs[job].salary)
                        TriggerClientEvent('esx:showNotification', targetPlayer.source, 
                            string.format(Config.PaymentMessage, Config.Jobs[job].salary))
                    end
                end
            end
            TriggerClientEvent('esx:showNotification', source, 'Pagos forzados realizados para todos los trabajos')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'No tienes permisos para usar este comando')
    end
end, false)