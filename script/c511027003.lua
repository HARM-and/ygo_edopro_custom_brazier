--Incarnation du Brazier
function c511027003.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_UPDATE_ATTACK)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511027003.target)
	e1:SetOperation(c511027003.activate)
	c:RegisterEffect(e1)
end

function c511027003.filter1(c)
	return c:IsSetCard(0xb3a)
end