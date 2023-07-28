--Grand Brazier
function c511027005.initial_effect(c)
	c:EnableCounterPermit(0xb3c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

	--Add counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511027005.op)
	c:RegisterEffect(e3)

end

function c511027005.op(e,tp,eg,ep,ev,re,r,rp)
	local c=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and c~=e:GetHandler() then
		e:GetHandler():AddCounter(0xb3c,1)
	end
end

function c511027005.rcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActivated() and bit.band(r,REASON_COST)~=0 and ep==e:GetOwnerPlayer() and e:GetHandler():GetCounter(0xb3c)>=ev
end

function c511027005.rop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(ep,0xb3c,ev,REASON_EFFECT)
end

function c511027005.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_RULE+REASON_REPLACE)
		and e:GetHandler():IsCanRemoveCounter(tp,0xb3c,1,REASON_EFFECT) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end

function c511027005.desrepop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0xb3c,1,REASON_EFFECT)
end

function c511027005.addop2(e,tp,eg,ep,ev,re,r,rp)
	local count=0
	local c=eg:GetFirst()
	while c~=nil do
		if c~=e:GetHandler() and c:IsOnField() and c:IsReason(REASON_DESTROY) then
			count=count+c:GetCounter(0xb3c)
		end
		c=eg:GetNext()
	end
	if count>0 then
		e:GetHandler():AddCounter(0xb3c,count)
	end
end