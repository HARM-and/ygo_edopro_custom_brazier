--Hello World
function c027488001.initial_effect(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EFFECT_DRAW_COUNT)
    e1:SetValue(5)
    c:RegisterEffect(e1)
end