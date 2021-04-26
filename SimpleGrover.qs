namespace SimpleGrover {
    open Microsoft.Quantum.Samples.Reflections;
    
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    
    @EntryPoint()
    operation SearchForMarkedInput(nQubits : Int) : Result[] {
        Message("Entry");
        use qubits = Qubit[nQubits];
        PrepareUniform(qubits);
        for idxIteration in 0..NIterations(nQubits) - 1 { 
            ReflectAboutMarked(qubits);
            ReflectAboutUniform(qubits);
        }
        DumpMachine();
        return ForEach(MResetZ, qubits);
    }
    
    function NIterations(nQubits : Int) : Int {
        let nItems = 1 <<< nQubits;
        let len = IntAsDouble(nQubits);
        let angle = Sqrt(IntAsDouble(nItems)/len);
        let nIterations = Round(0.25 * PI() * angle -0.5);
        Message($"Trying iteration {nIterations}");
        Message($"n {len}");
        Message($"2^n {nItems}");
        Message($"ratio {angle}");
        return nIterations;
    }
}