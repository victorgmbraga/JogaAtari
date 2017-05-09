classdef experience < handle
    properties
        estado;
        acao;
        recompensa;
        proxEstado;
    end
    methods
        function store(self,estado_p,acao_p,recompensa_p,prox_estado_p)
            self.estado = estado_p;
            self.acao = acao_p;
            self.recompensa = recompensa_p;
            self.proxEstado = prox_estado_p; 
        end
        function self = get(self)
            return;
        end
    end
end
            