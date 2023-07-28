--Forêt Embrazier
local s,id=GetID()
function c511027004.initial_effect(c)
    c:EnableCounterPermit(0xb3c)

	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511027004.cost)
	e1:SetTarget(c511027004.target)
	e1:SetOperation(c511027004.activate)
	c:RegisterEffect(e1)
end

c511027004.counter_list={COUNTER_SPELL}

function c511027004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,0xb3c,0,COUNTER_SPELL,3,REASON_COST) end
	Duel.RemoveCounter(tp,0xb3c,0,COUNTER_SPELL,3,REASON_COST)
end

function c511027004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end

function c511027004.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end