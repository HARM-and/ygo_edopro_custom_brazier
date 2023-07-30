--Ifrit, Grand Esprit Embrazier
local s,id=GetID()
function c511027006.initial_effect(c)
    c:EnableCounterPermit(0xb3c)

    --gain atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.atkcon)
	e1:SetValue(1000)
	c:RegisterEffect(e1)

    --gain attack twice a turn
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
    e1:SetCondition(s.twicecon)
    c:RegisterEffect(e2)
end

function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xb3c)>=0
end

function s.twicecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xb3c)>=0
end

function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end