--ウィッチクラフト・バイストリート
--Witchcrafter Bystreet
--Scripted by Naim
local s,id=GetID()
function s.initial_effect(c)

	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xb3a))
	e2:SetValue(s.indct)
	c:RegisterEffect(e2)
end

s.listed_series={0xb3a}

function s.indct(e,re,r,rp)
	if (r&REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else
		return 0
	end
end
