using Test
using Jrill

@testset "Jrill" begin
   @test 1  == 1
   @test typeof(Jrill.drill_connection(ENV["DRILL_HOST"], 8047)) == Jrill.DrillConnection
end
