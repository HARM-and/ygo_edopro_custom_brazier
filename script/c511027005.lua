--Grand Brazier
local s,id=GetID()
function s.initial_effect(c)
	c:SetUniqueOnField(1,0,id)
	c:EnableCounterPermit(0xb3c)

	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

	--Indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xb3a))
	e2:SetValue(s.indct)
	c:RegisterEffect(e2)

	--Add counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(s.spcon)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)

	-- Ritual Summon 1 "Brazier" monster
	local e4=Ritual.CreateProc(c,RITPROC_GREATER,aux.FilterBoolFunction(Card.IsSetCard,0xb3a),nil,aux.Stringid(id,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(s.rscost)
	c:RegisterEffect(e4)

end

s.listed_series={0xb3a}

function s.indct(e,re,r,rp)
	if (r&REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else
		return 0
	end
end

--If a Pyro monster is sent to GY
function s.cfilter(c,tp)
	return c:IsRace(RACE_PYRO) and c:IsMonster() and c:IsControler(tp)
end

--If it ever happened
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end

--Performing the effect of adding a counter
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0xb3c,1)
end

--Performing the effect of removing a counter
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(0xb3c,1)
end

--Performing the effect of removing a counter
function s.rscost(e,tp,eg,ep,ev,re,r,rp)
	Duel.Release(e:GetHandler(),REASON_COST)
end