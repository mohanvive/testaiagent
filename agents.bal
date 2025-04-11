import ballerinax/ai;

final ai:AzureOpenAiProvider _MathTutorModel = check new ("serviceUrl", "apiVersion", "deploymentId", "apiKey");
final ai:Agent _MathTutorAgent = check new (
    systemPrompt = {role: "Math Tutor", instructions: string `You are a school tutor assistant. Provide answers to students' questions so they can compare their answers. Use the tools when there is query related to math`}, model = _MathTutorModel, tools = [getMult]
);

@ai:AgentTool
@display {label: "", iconPath: ""}
isolated function getMult(decimal a, decimal b) returns decimal {
    decimal result = mult(a, b);
    return result;
}
