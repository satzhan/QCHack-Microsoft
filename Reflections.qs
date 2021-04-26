namespace Microsoft.Quantum.Samples.Reflections {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    
    
    operation ReflectAboutMarked(inputQubits : Qubit[]) : Unit {
        Message("Reflecting about marked state ..");
        use outputQubit = Qubit();
        within {
            X(outputQubit);
            H(outputQubit);
//             ApplyToEachA(X, inputQubits[...2...]);
        } apply {
            for i in 0 .. Length(inputQubits) - 1 {
                within {
                    X(inputQubits[i]);
                    PrepareAllOnes(inputQubits);
                } apply {
                    Controlled X(inputQubits, outputQubit);
                }
            }
        }
    }
    
    operation ReflectAboutUniform(inputQubits : Qubit[]) : Unit {
        within {
            Adjoint PrepareUniform(inputQubits);
            PrepareAllOnes(inputQubits);
        } apply {
            ReflectAboutAllOnes(inputQubits);
        }
    }
    operation ReflectAboutAllOnes(inputQubits : Qubit[]) : Unit {
        Controlled Z(Most(inputQubits), Tail(inputQubits));
    }
    operation PrepareUniform(inputQubits : Qubit[]) : Unit is Adj + Ctl {
        ApplyToEachCA(H, inputQubits);
    }
    operation PrepareAllOnes(inputQubits : Qubit[]) : Unit is Adj + Ctl {
        ApplyToEachCA(X, inputQubits);
    }   
}
















