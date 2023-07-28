--Larbin du Brazier
function c511027001.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetValue(2)
	c:RegisterEffect(e1)
end