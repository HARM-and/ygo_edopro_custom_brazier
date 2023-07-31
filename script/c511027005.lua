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
	e2:SetCondition(s.indcon)
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
	c:RegisterEffect(e4)

	-- Add all counter to a "Brazier" Ritual monster
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(s.spcon)
	e6:SetOperation(s.tcop)
	c:RegisterEffect(e6)

end

s.listed_series={0xb3a}

--Je sais pas ce que ca fait ...
function s.indct(e,re,r,rp)
	if (r&REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else
		return 0
	end
end

--If a Pyro monster
function s.filter1(c,tp)
	return c:IsRace(RACE_PYRO) and c:IsMonster() and c:IsControler(tp)
end

--If a "Brazier" monster
function s.filter2(c,tp)
	return c:IsSetCard(0xb3a) and c:IsControler(tp) and c:IsSummonType(SUMMON_TYPE_RITUAL)
end

--If it ever happened 1
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.filter1,1,nil,tp)
end

--If it ever happened 1
function s.indcon(e,tp,eg,ep,ev,re,r,rp)
	if rp==1-ep then
		return 1
	else
		return 0
	end
end

--If it ever happened 2
function s.tccon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.filter2,1,nil,tp)
end

--Performing the effect of adding a counter
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0xb3c,1)
end

--Add counter to Ritual monster before discard
function s.tcop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local count=e:GetHandler():GetCounter(0xb3c)
	tc:AddCounter(0xb3c,count)
	Duel.SendtoGrave(e:GetHandler(), REASON_EFFECT)
end