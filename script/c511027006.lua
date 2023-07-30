--Ifrit, Grand Esprit Embrazier
local s,id=GetID()
function c511027006.initial_effect(c)
    c:EnableCounterPermit(0xb3c)

    --gain atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK+EFFECT_UPDATE_DEFENSE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.atkcon)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
end

function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xb3c)>=0
end

function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end