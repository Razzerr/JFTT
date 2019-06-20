#include <string>
#include <vector>
#include <iostream>
#include <locale>
#include <codecvt>

using namespace std;

int* ComputePrefixFunction(wstring P){
    int k = 0, m = P.length();
    int* pi = new int[m];
    pi[0] = 0;

    for (int q = 1; q < m; q++){
        while (k > 0 and P[k] != P[q]){
            k = pi[k-1];
        }
        if (P[k] == P[q]){
            k = k + 1;
        }
        pi[q] = k;
    }
    return pi;
}

void KMPMatcher(wstring T, wstring P){
    int q = 0, n = T.length(), m = P.length();
    int* pi = ComputePrefixFunction(P);

    for (int i = 0; i < n; i++){
        while (q > 0 && P[q] != T[i]){
            q = pi[q-1];
        }
        if (P[q] == T[i]){
            q = q + 1;
        }
        if (q == m) {
            if (m != 0) printf("Pattern occurs with shift %i\n", i+1-m);
            else printf("Pattern occurs with shift %i\n", i-m);
            q = pi[q-1];
        }
    }
    return;
}

int main(int argc, char** argv){
    wstring_convert<codecvt_utf8_utf16<wchar_t>> converter;

    string T = "ćąćą?ąćąćąćąćą?";
    wstring target = converter.from_bytes(T);

    vector<string> P = {"ę", "ę?", "ćą", "ćąć", "ćą?", "?ąć", "ćąćą", "ąćą", ""};
    int i = 0;
    for (string p : P){
        wstring pattern = converter.from_bytes(p);
        KMPMatcher(target, pattern);
            cout<<"End of search for pattern \'"<<p<<"\'\n\n";
        i++;
    } 
    return 0;
}