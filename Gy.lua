local mostExpensiveCar = nil
local highestPrice = 0

print("🔍 جاري المسح الشامل للبحث عن أغلى سيارة...")

-- مسح كل الكائنات الموجودة في عالم اللعبة (Workspace) بالكامل
for _, object in pairs(workspace:GetDescendants()) do
    
    -- نتحقق أولاً إذا كان الكائن عبارة عن "مجسم" (Model)
    if object:IsA("Model") then
        
        -- نبحث عن أي قيمة للسعر داخل هذا المجسم (سواء كان اسمها Price أو Cost)
        local priceValue = object:FindFirstChild("Price") or object:FindFirstChild("Cost")
        
        -- لضمان أن هذا المجسم سيارة وليس مجرد أداة أخرى للبيع، نبحث عن مقعد السائق
        local isVehicle = object:FindFirstChildWhichIsA("VehicleSeat", true) or object:FindFirstChild("DriveSeat", true)

        -- إذا تحققنا أنه يمتلك سعراً ومقعد قيادة
        if priceValue and priceValue:IsA("IntValue") and isVehicle then
            
            -- نقارن السعر لنجد الأغلى
            if priceValue.Value > highestPrice then
                highestPrice = priceValue.Value
                mostExpensiveCar = object
            end
            
        end
    end
end

-- عرض النتائج
if mostExpensiveCar then
    local carName = mostExpensiveCar.Name
    -- نجلب إحداثيات السيارة بدقة
    local carLocation = mostExpensiveCar:GetPivot().Position
    
    print("🚗 تم العثور على أغلى سيارة!")
    print("الاسم: " .. carName)
    print("السعر: " .. highestPrice)
    print("المكان (X, Y, Z): " .. tostring(carLocation))
else
    print("❌ لم يتم العثور على أي سيارات معروضة للبيع باستخدام البحث الشامل. قد تكون اللعبة تستخدم نظاماً مختلفاً لحفظ الأسعار (مثل UI أو Attributes).")
end
