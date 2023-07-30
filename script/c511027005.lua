--Grand Brazier
local s,id=GetID()
function s.initial_effect(c)
	c:EnableCounterPermit(0xb3c)

	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xb3a))
	e2:SetValue(aux.TargetBoolFunction(Card.IsRace,RACE_PYRO))
	c:RegisterEffect(e2)

	--Add counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTarget(s.onlyPyro)
	e3:SetOperation(s.op)
	c:RegisterEffect(e3)
end

s.listed_series={0xb3a}

function s.indct(e,re,r,rp)
	if (r&REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else
		return 0
	end
end

function s.op(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0xb3c,1)
end
